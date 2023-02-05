defmodule Username do
  def sanitize([]), do: ''

  def sanitize([first_letter | rest]) do
    case first_letter do
      first_letter when first_letter === ?ä -> [?a, ?e | sanitize(rest)]
      first_letter when first_letter === ?ö -> [?o, ?e | sanitize(rest)]
      first_letter when first_letter === ?ü -> [?u, ?e | sanitize(rest)]
      first_letter when first_letter === ?ß -> [?s, ?s | sanitize(rest)]
      first_letter when first_letter === ?_ -> [?_ | sanitize(rest)]
      first_letter when first_letter in ?a..?z -> [first_letter | sanitize(rest)]
      _ -> sanitize(rest)
    end
  end
end
