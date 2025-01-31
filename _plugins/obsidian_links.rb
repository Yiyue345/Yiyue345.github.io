module Jekyll
    module ObsidianLinkFilter
      def convert_obsidian_links(input)
        # 匹配 Obsidian 的 [[链接]] 语法
        input.gsub(/\[\[([^\|\]]+?)(?:\|([^\]]+?))?\]\]/) do
          # 提取链接目标和显示文本
          target = $1.strip
          display_text = $2 ? $2.strip : target
  
          # 处理带日期的文件名（如 2023-10-01-my-post → my-post）
          clean_target = target.gsub(/^\d{4}-\d{2}-\d{2}-/, '')
  
          # 生成 Jekyll post_url 标签
          "{% post_url #{clean_target} %}"
        end
      rescue => e
        # 错误处理（可选）
        Jekyll.logger.error "Obsidian Link Filter Error:", e.message
        input
      end
    end
  end
  
  # 向 Liquid 注册过滤器
  Liquid::Template.register_filter(Jekyll::ObsidianLinkFilter)