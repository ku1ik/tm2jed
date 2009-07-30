require 'sinatra/base'

module TextmateToJEditConverter
  class Application < Sinatra::Default
    
    set :run, false
    use_in_file_templates!
    
    get '/' do
      erb :index
    end
    
    post '/' do
      @result = JEditThemeWriter.new(TextmateThemeReader.new(params[:input]).get_theme).get_theme
      erb :result
    end
    
  end
end

__END__

@@ layout
<html>
<head>
</head>
<bodu>
<%= yield %>
</bodu>
</html>

@@ index
This is index:
<form action="/" method="POST">
<textarea name="input" style="width: 600px; height: 500px;"></textarea>
<input type="submit" value="Convert!" />
</form>

@@ result
This is result:
<pre><%= @result %></pre>