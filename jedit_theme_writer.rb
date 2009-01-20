
class JEditThemeWriter
  def initialize(theme)
    @theme = theme
    @lines = []
    prepare
  end
  
  def escape_value(val)
    val.gsub(/:/, '\:').gsub(/#/, '\#')
  end

  def prepare_color(col)
    col.downcase
  end

  def add_comment(comment)
    @lines << "\##{comment}"
  end

  def add_prop(name, value)
    @lines << "#{name}=#{escape_value(value).strip}"
  end

  def add_style(name, style)
    if style.to_s =~ /missing prop/ || style.nil?
      #puts style
      return
    end
    
    s = ""
    s << " color:#{prepare_color(style[:foreground])}" if style[:foreground] 
    s << " bgColor:#{prepare_color(style[:background])}" if style[:background]
    if s.size > 1 && style[:fontStyle]
      s << " style:"
      s << "b" if style[:fontStyle] =~ /bold/
      # s << "u" if style[:fontStyle] =~ /underline/
      s << "i" if style[:fontStyle] =~ /italic/
    end
    add_prop(name, s) if s.size > 1
  end
  
  def prepare
    add_comment "#{@theme.name} jEdit Editor Scheme"
    add_comment "generated from textmate theme with tm2jed\n"
    
    add_prop "scheme.name", @theme.name
    #add_prop "console.font", "Monospaced"
    add_prop "view.fgColor", @theme.foreground
    add_prop "view.bgColor", @theme.background
    add_prop "view.caretColor", @theme.caret
    add_prop "view.selectionColor", @theme.selection
    add_prop "view.eolMarkerColor", @theme.eol_marker
    add_prop "view.lineHighlightColor", @theme.line_highlight
    
    # #foo
    add_style "view.style.comment1", @theme.comment
    # "foo"
    add_style "view.style.literal1", @theme.string
    # :foo
    add_style "view.style.label", @theme.label
    # 123
    add_style "view.style.digit", @theme.number
    # class, def, if, end
    add_style "view.style.keyword1", @theme.keyword
    # require, include
    add_style "view.style.keyword2", @theme.keyword
    # true, false, nil
    add_style "view.style.keyword3", @theme.keyword2
    # @foo
    add_style "view.style.keyword4", @theme.variable
    # = < + -
    add_style "view.style.operator", @theme.operator
    # def foo
    add_style "view.style.function", @theme.function
    # /jola/
    add_style "view.style.literal3", @theme.regexp
    # MyClass, USER_SPACE
    #add_style "view.style.literal4", @theme.constant
    # <div>
    add_style "view.style.markup", @theme.markup

    #TODO: gutter etc
  end
    
  def get_theme
    @lines.join("\n")+"\n"
  end
end

