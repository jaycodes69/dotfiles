-- ~/.config/nvim/lua/snippets/cpp.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	s("cp", {
		t({
			"#include <bits/stdc++.h>",
			"using namespace std;",
			"",
			"int main() {",
			"    ios::sync_with_stdio(false);",
			"    cin.tie(nullptr);",
			"",
			"    ",
		}),
		i(1, "// your code here"),
		t({
			"",
			"",
			"    return 0;",
			"}",
		}),
	}),
}
