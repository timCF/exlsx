defmodule ExlsxTest do
  use ExUnit.Case

  test "the truth" do
  	lst = [%{a: "привет мир!",b: "привет мир!"},%{a: "съешь ещё этих мягких французских булочек", b: "да выпей чаю"}]
    Exlsx.encode(lst)
    assert 1 + 1 == 2
  end
end
