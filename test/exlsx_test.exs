defmodule ExlsxTest do
  use ExUnit.Case
  @dir "./tmp"
  test "the truth" do
	File.rm_rf(@dir)
  	lst = [%{a: "привет мир!",b: "привет мир!"},%{a: "съешь ещё этих мягких французских булочек", b: "да выпей чаю"}]
    File.mkdir!(@dir)
	File.write!(@dir<>"/sample.xlsx", Exlsx.encode(lst))
	File.write!(@dir<>"/sample.xls", Exlsx.encode(lst, %{separator: ";", header: true}, "xls"))
    assert 1 + 1 == 2
  end
end
