local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

return {
	-- Basic main
	s("cppmain", {
		t({
			"#include <iostream>",
			"using namespace std;",
			"",
			"int main() {",
			"  ",
		}),
		i(0),
		t({
			"",
			"  return 0;",
			"}",
		}),
	}),

	-- Main with Fast IO
	s("cppio", {
		t({
			"#include <bits/stdc++.h>",
			"using namespace std;",
			"",
			"int main() {",
			"  ios::sync_with_stdio(false);",
			"  cin.tie(nullptr);",
			"",
			"  ",
		}),
		i(0),
		t({
			"",
			"  return 0;",
			"}",
		}),
	}),

	-- Test cases (while T--)
	s("cpptest", {
		t({
			"#include <bits/stdc++.h>",
			"using namespace std;",
			"",
			"int main() {",
			"  ios::sync_with_stdio(false);",
			"  cin.tie(nullptr);",
			"",
			"  int T;",
			"  cin >> T;",
			"  while (T--) {",
			"    ",
		}),
		i(0),
		t({
			"  }",
			"  return 0;",
			"}",
		}),
	}),

	-- Function snippet
	s("cppfunc", {
		i(1, "int"),
		t(" "),
		i(2, "func"),
		t("("),
		i(3, "int x"),
		t({ ") {", "  " }),
		i(0),
		t({ "", "}" }),
	}),

	-- Vector declaration
	s("cppvec", {
		t("vector<"),
		i(1, "int"),
		t("> "),
		i(2, "v"),
		t(";"),
	}),

	-- For loop
	s("cppfor", {
		t("for (int "),
		i(1, "i"),
		t(" = "),
		i(2, "0"),
		t("; "),
		rep(1),
		t(" < "),
		i(3, "n"),
		t("; "),
		rep(1),
		t("++) {"),
		t({ "", "  " }),
		i(0),
		t({ "", "}" }),
	}),

	-- Optional: Fast define int → long long
	s("cpplong", {
		t("#define int long long"),
	}),
}
