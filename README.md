Exlsx
=====

WARNING!!! external deps

```
apt-get install libreoffice
apt-get install python
pip install csv2xlsx
```

check it works

```
mix test
```

only one public function

```
binary = Exlsx.encode(lst = [_|_], opts = %{separator: ";", str_separator: "\r\n", keys: [:key2, :key1], header: true})
```