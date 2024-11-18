{ ... }:
{
  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        insert_final_newline = true;
        trim_trailing_whitespace = true;

        indent_style = "space";
        indent_size = 2;
        max_line_length = 80;
      };

      "*.{java,kt,py,sql}" = {
        indent_style = "space";
        indent_size = 4;
      };

      "*.{java,kt,sql}" = {
        max_line_length = 120;
      };

      "*.{c,go,ha}" = {
        indent_style = "tab";
        indent_size = 8;
      };

      "Makefile" = {
        indent_style = "tab";
      };
    };
  };
}
