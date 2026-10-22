require 'test_helper'

module HtmlCompressor

  class TestCompressor < Minitest::Test

    def test_enabled
      source = read_resource("testEnabled.html")
      result = read_resource("testEnabledResult.html")

      compressor = Compressor.new(:enabled => false)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_spaces_inside_tags
      source = read_resource("testRemoveSpacesInsideTags.html")
      result = read_resource("testRemoveSpacesInsideTagsResult.html")

      compressor = Compressor.new(:remove_multi_spaces => false)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_spaces_inside_tags_disabled
      source = read_resource("testRemoveSpacesInsideTags.html")
      result = read_resource("testRemoveSpacesInsideTagsDisabledResult.html")

      compressor = Compressor.new(:remove_multi_spaces => false, :remove_spaces_inside_tags => false)

      assert_equal result, compressor.compress(source)
    end


    def test_remove_comments
      source = read_resource("testRemoveComments.html")
      result = read_resource("testRemoveCommentsResult.html")

      compressor = Compressor.new(:remove_comments => true, :remove_intertag_spaces => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_quotes
      source = read_resource("testRemoveQuotes.html")
      result = read_resource("testRemoveQuotesResult.html")

      compressor = Compressor.new(:remove_quotes => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_multi_spaces
      source = read_resource("testRemoveMultiSpaces.html")
      result = read_resource("testRemoveMultiSpacesResult.html")

      compressor = Compressor.new(:remove_multi_spaces => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_intertag_spaces
      source = read_resource("testRemoveIntertagSpaces.html")
      result = read_resource("testRemoveIntertagSpacesResult.html")

      compressor = Compressor.new(:remove_intertag_spaces => true)

      assert_equal result, compressor.compress(source)
    end

    def test_preserve_patterns
      source = read_resource("testPreservePatterns.html")
      result = read_resource("testPreservePatternsResult.html")

      preservePatterns = [
        Compressor::PHP_TAG_PATTERN,                                      # <?php ... ?> blocks
        Compressor::SERVER_SCRIPT_TAG_PATTERN,                            # <% ... %> blocks
        Compressor::SERVER_SIDE_INCLUDE_PATTERN,                          # <!--# ... --> blocks
        Regexp.new("<jsp:.*?>", Regexp::MULTILINE | Regexp::IGNORECASE)   # <jsp: ... > tags
      ]

      compressor = Compressor.new(
        :preserve_patterns => preservePatterns,
        :remove_comments => true,
        :remove_intertag_spaces => true
      )

      assert_equal result, compressor.compress(source)
    end

    def test_compress
      source = read_resource("testCompress.html")
      result = read_resource("testCompressResult.html")

      compressor = Compressor.new(:compress_js_templates => true)

      assert_equal result, compressor.compress(source)
    end

    def test_simple_doctype
      source = read_resource("testSimpleDoctype.html")
      result = read_resource("testSimpleDoctypeResult.html")

      compressor = Compressor.new(:simple_doctype => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_script_attributes
      source = read_resource("testRemoveScriptAttributes.html")
      result = read_resource("testRemoveScriptAttributesResult.html")

      compressor = Compressor.new(:remove_script_attributes => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_style_attributes
      source = read_resource("testRemoveStyleAttributes.html")
      result = read_resource("testRemoveStyleAttributesResult.html")

      compressor = Compressor.new(:remove_style_attributes => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_link_attributes
      source = read_resource("testRemoveLinkAttributes.html")
      result = read_resource("testRemoveLinkAttributesResult.html")

      compressor = Compressor.new(:remove_link_attributes => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_form_attributes
      source = read_resource("testRemoveFormAttributes.html")
      result = read_resource("testRemoveFormAttributesResult.html")

      compressor = Compressor.new(:remove_form_attributes => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_input_attributes
      source = read_resource("testRemoveInputAttributes.html")
      result = read_resource("testRemoveInputAttributesResult.html")

      compressor = Compressor.new(:remove_input_attributes => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_javascript_protocol
      source = read_resource("testRemoveJavaScriptProtocol.html")
      result = read_resource("testRemoveJavaScriptProtocolResult.html")

      compressor = Compressor.new(:remove_javascript_protocol => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_http_protocol
      source = read_resource("testRemoveHttpProtocol.html")
      result = read_resource("testRemoveHttpProtocolResult.html")

      compressor = Compressor.new(:remove_http_protocol => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_https_protocol
      source = read_resource("testRemoveHttpsProtocol.html")
      result = read_resource("testRemoveHttpsProtocolResult.html")

      compressor = Compressor.new(:remove_https_protocol => true)

      assert_equal result, compressor.compress(source)
    end

    def test_preserve_line_breaks
      source = read_resource("testPreserveLineBreaks.html")
      result = read_resource("testPreserveLineBreaksResult.html")

      compressor = Compressor.new(:preserve_line_breaks => true)

      assert_equal result, compressor.compress(source)
    end

    def test_remove_surrounding_spaces
      source = read_resource("testSurroundingSpaces.html")
      result = read_resource("testSurroundingSpacesResult.html")

      compressor = Compressor.new(
        :remove_intertag_spaces => true,
        :remove_surrounding_spaces => "p,br"
      )

      assert_equal result, compressor.compress(source)
    end

    def test_simple_boolean_attributes
      source = read_resource("testSimpleBooleanAttributes.html")
      result = read_resource("testSimpleBooleanAttributesResult.html")

      compressor = Compressor.new(:simple_boolean_attributes => true)

      assert_equal result, compressor.compress(source)
    end

    def test_preserve_textarea
      source = read_resource("testPreserveTextareas.html")
      result = read_resource("testPreserveTextareasResult.html")

      compressor = Compressor.new

      assert_equal result, compressor.compress(source)
    end

    protected_elements = {
      'style' => '<style>.button { color: red; }</style>',
      'script' => '<script>alert("safe");</script>',
      'pre' => '<pre>  preserve   spacing  </pre>',
      'textarea' => '<textarea>  preserve   text  </textarea>'
    }
    comment_layouts = {
      'single_line' => '<!-- documentation mentions %s -->',
      'multiline' => "<!--\n documentation mentions %s\n-->"
    }

    protected_elements.each do |element, real_block|
      opening_variants = {
        'lowercase' => "<#{element}>",
        'uppercase' => "<#{element.upcase}>",
        'attributes' => "<#{element} data-documentation=\"true\">",
        'multiline_tag' => "<#{element}\n data-documentation=\"true\">"
      }

      opening_variants.each do |opening_name, comment_text|
        comment_layouts.each do |layout_name, comment_layout|
          case_name = [element, opening_name, layout_name].join('_')

          define_method("test_#{case_name}_does_not_capture_following_content") do
            source = (comment_layout % comment_text) \
              + "<div>before-#{case_name}</div>" \
              + "{% if user.enabled %}<div>liquid-#{case_name}</div>{% endif %}" \
              + "#{real_block}<!-- later ordinary comment --><div>after-#{case_name}</div>"

            assert_compression_integrity(
              case_name,
              source,
              ["before-#{case_name}", "liquid-#{case_name}", real_block, "after-#{case_name}"],
              ['documentation mentions', 'later ordinary comment']
            )
          end
        end
      end
    end

    def test_complete_protected_element_examples_in_comments_remain_removable
      %w(style script pre textarea).each do |element|
        real_block = "<#{element}>real-#{element}</#{element}>"
        source = "<!-- example: <#{element}>fake</#{element}> -->#{real_block}"

        assert_compression_integrity(
          element,
          source,
          [real_block],
          ['example:', 'fake']
        )
      end
    end

    conditional_openings = {
      'lowercase' => '<![if mso]>',
      'uppercase' => '<![IF MSO]>',
      'comment_prefixed' => '<!--[if mso]>',
      'complex_expression' => '<![if (gte mso 9)|(IE)]>',
      'multiline_expression' => "<![if\n mso]>"
    }
    conditional_layouts = {
      'single_line' => '<!-- documentation mentions %s -->',
      'multiline' => "<!--\n documentation mentions %s\n-->"
    }
    real_conditionals = {
      'downlevel_hidden' => '<!--[if mso]><div>conditional-%s</div><![endif]-->',
      'downlevel_revealed' => '<!--[if !mso]><!--><div>conditional-%s</div><!--<![endif]-->'
    }

    conditional_openings.each do |opening_name, conditional_opening|
      conditional_layouts.each do |layout_name, comment_layout|
        real_conditionals.each do |conditional_name, conditional_template|
          case_name = [opening_name, layout_name, conditional_name].join('_')

          define_method("test_#{case_name}_conditional_does_not_capture_following_content") do
            conditional = conditional_template % case_name
            source = (comment_layout % conditional_opening) \
              + "<div>before-#{case_name}</div>" \
              + "{% if user.enabled %}<div>liquid-#{case_name}</div>{% endif %}" \
              + "#{conditional}<!-- later ordinary comment --><div>after-#{case_name}</div>"

            assert_compression_integrity(
              case_name,
              source,
              ["before-#{case_name}", "liquid-#{case_name}", "conditional-#{case_name}", "after-#{case_name}"],
              ['documentation mentions', 'later ordinary comment']
            )
          end
        end
      end
    end

    event_openings = {
      'double_quoted_lowercase' => ['onclick="', '"'],
      'double_quoted_uppercase' => ['ONCLICK="', '"'],
      'double_quoted_spaced' => ['onclick = "', '"'],
      'double_quoted_different_event' => ['onmouseenter="', '"'],
      'single_quoted_lowercase' => ["onclick='", "'"],
      'single_quoted_spaced' => ["onclick = '", "'"]
    }

    event_openings.each do |case_name, (event_opening, quote)|
      define_method("test_#{case_name}_event_does_not_capture_following_content") do
        source = "<div>before-#{case_name}</div>" \
          "<!-- documentation mentions #{event_opening} unfinished -->" \
          "<div title=#{quote}content-#{case_name}#{quote}>content</div>" \
          "<!-- later ordinary comment --><div>after-#{case_name}</div>"

        assert_compression_integrity(
          case_name,
          source,
          ["before-#{case_name}", "content-#{case_name}", "after-#{case_name}"],
          ['documentation mentions', 'later ordinary comment']
        )
      end
    end

    def test_comment_boundaries_are_respected_when_comment_removal_is_disabled
      source = '<!-- docs mention <style> --><div>keep-me</div><style>.real { color: blue; }</style>'

      assert_equal source, Compressor.new(:remove_comments => false).compress(source)
    end

    def test_conditional_comment_boundaries_are_respected_when_comment_removal_is_disabled
      source = '<!-- docs mention <![if mso]> --><div>before</div>' \
        '<!--[if mso]><div>conditional</div><![endif]--><div>after</div>'

      assert_equal source, Compressor.new(:remove_comments => false).compress(source)
    end

    def test_comment_placeholders_are_restored_inside_preserved_blocks
      source = '<pre><!-- docs mention <style> -->  pre   value  </pre>' \
        '<textarea><!-- docs mention <script> --> textarea value </textarea>' \
        '<script><!-- docs mention <pre> --> var value = 1; </script>' \
        '<style><!-- docs mention <textarea> --> .value { color: red; } </style>' \
        '<script type="application/json"><!-- docs mention <style> -->{"key":"value"}</script>'
      result = Compressor.new.compress(source)

      assert_includes result, '<!-- docs mention <style> -->  pre   value  '
      assert_includes result, '<!-- docs mention <script> --> textarea value '
      assert_includes result, '<!-- docs mention <pre> --> var value = 1; '
      assert_includes result, '<!-- docs mention <textarea> --> .value { color: red; } '
      assert_includes result, '<!-- docs mention <style> -->{"key":"value"}'
      refute_includes result, '%%%~COMPRESS~COMMENT~'
    end

    def test_single_quoted_inline_events_remain_supported
      source = "<button onclick='alert(\\'safe\\')'>Go</button>"

      assert_equal source, Compressor.new.compress(source)
    end

    def test_compress_custom_html_templates
      source = read_resource("testCompressCustomHtmlTemplates.html")
      result = read_resource("testCompressCustomHtmlTemplatesResult.html")
      compressor = Compressor.new(:compress_js_templates => ['text/html'], :remove_quotes => true)
      assert_equal result, compressor.compress(source)
    end

    def test_dont_replace_javascript_inside_js_templates
      source = read_resource("testCompressCustomHtmlTemplates.html")
      result = read_resource("testCompressCustomHtmlTemplates.html")
      compressor = Compressor.new(:compress_js_templates => false, :remove_quotes => true)
      assert_equal result, compressor.compress(source)
    end

    def test_javascript_compressor_not_found
      source = read_resource("testCompressJavaScript.html");

      compressor = Compressor.new(
        :compress_javascript => true,
        :javascript_compressor => :not_existing_compressor,
        :remove_intertag_spaces => true,
        :compress_js_templates => true
      )

      exception = assert_raises(NotFoundCompressorError) do
        compressor.compress(source)
      end

      expect_message = 'JavaScript Compressor "not_existing_compressor" not found, please check :javascript_compressor option'
      assert_equal(expect_message, exception.message)
    end

    def test_css_compressor_not_found
      source = read_resource("testCompressCss.html");

      compressor = Compressor.new(
        :enabled => true,
        :compress_css => true,
        :css_compressor => :not_existing_compressor,
        :compress_javascript => false
      )

      exception = assert_raises(NotFoundCompressorError) do
        compressor.compress(source)
      end

      expect_message = 'CSS Compressor "not_existing_compressor" not found, please check :css_compressor option'
      assert_equal(expect_message, exception.message)
    end

    private

    def assert_compression_integrity(name, source, preserved, removed)
      result = Compressor.new.compress(source)
      positions = preserved.map { |value| result.index(value) }

      assert positions.all?, "#{name}: missing preserved content in #{result.inspect}"
      assert_equal positions.sort, positions, "#{name}: preserved content changed order"
      removed.each do |value|
        refute_includes result, value, "#{name}: removable comment content survived"
      end
    end
  end

end
