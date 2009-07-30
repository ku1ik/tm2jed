require 'sinatra/base'

module TextmateToJEditConverter
  class Application < Sinatra::Default
    
    set :run, false
    use_in_file_templates!
    
    get '/' do
      erb :index
    end
    
    post '/' do
      if params[:data]
        @result = JEditThemeWriter.new(TextmateThemeReader.new(params[:data][:tempfile].read).get_theme).get_theme
        erb :result
      else
        @message = 'Please choose a file with Textmate theme to convert.'
        erb :index
      end
    end
    
  end
end

__END__

@@ layout
<html>
<head>
  <title>Online Textmate to JEdit colour scheme converter</title>
  <style>
    
  </style>
</head>
<bodu>
<%= yield %>
</bodu>
</html>

@@ index
This is index:<br/>
<% if @message %><p><%= @message %></p><% end %>
<form action="/" method="POST" enctype="multipart/form-data">
<input type="file" size="30" name="data"/>
<input type="submit" value="Convert!" />
</form>

@@ result
This is result:
<pre><%= @result %></pre>