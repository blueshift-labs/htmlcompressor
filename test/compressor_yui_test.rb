require 'test_helper'

module HtmlCompressor

  class TestCompressor < Minitest::Test

    def test_compress_javascript_yui
      source = read_resource("testCompressJavaScript.html");
      result = read_resource("testCompressJavaScriptYuiResult.html");

      compressor = Compressor.new(
        :compress_javascript => true,
        :javascript_compressor => :yui,
        :remove_intertag_spaces => true,
        :compress_js_templates => true
      )

      assert_equal result, compressor.compress(source)
    end

    def test_compress_css
      source = read_resource("testCompressCss.html")
      result = read_resource("testCompressCssResult.html")

      compressor = Compressor.new(
        :compress_css => true,
        :css_compressor => :yui,
        :remove_intertag_spaces => true
      )

      assert_equal result, compressor.compress(source)
    end

    def test_compress_css_with_comment_boundaries_and_preserved_template_syntax
      source = '<!-- docs mention <style> and <![if mso]> -->' \
        '<div>before</div>' \
        '{% if user.enabled %}<div>keep</div>{% endif %}' \
        '<style>.button { color: red; }</style>' \
        '<!--[if mso]><table><tr><td>mso</td></tr></table><![endif]-->' \
        '<!-- later comment -->' \
        '<div>after</div>'
      result = '<div>before</div>' \
        '{% if user.enabled %}<div>keep</div>{% endif %}' \
        '<style>.button{color:red}</style>' \
        '<!--[if mso]><table><tr><td>mso</td></tr></table><![endif]-->' \
        '<div>after</div>'
      preserve_patterns = [
        /\s?\{%.*?%\}\s?/im,
        /\s?\{\{.*?\}\}\s?/im,
        /<!--<!\[endif\]-->/im,
        /<!--\[if !mso\]><!-->/im,
        /<!-- End -->/im,
        /<!-->/im
      ]
      compressor = Compressor.new(
        :compress_css => true,
        :css_compressor => :yui,
        :remove_intertag_spaces => true,
        :preserve_patterns => preserve_patterns
      )

      assert_equal result, compressor.compress(source)
    end

  end

end
