class PostController < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), "..")
  set :view, Proc.new { File.join(root, "views") }

  configure :development do
    register Sinatra::Reloader
  end


  # $books = [
  #   {
  #     id: 0,
  #     title: "Book 1",
  #     body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  #   },
  #   {
  #     id: 1,
  #     title: "Book 2",
  #     body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  #   },
  #   {
  #     id: 2,
  #     title: "Book 3",
  #     body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  #   },
  #   {
  #     id: 3,
  #     title: "Book 4",
  #     body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  #   },
  #   {
  #     id: 4,
  #     title: "Book 5",
  #     body: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  #   }
  # ]

  get "/new" do
    @book = {
      id: "",
      title: "",
      body: ""
    }
    erb :'books/new'
  end

  get "/" do
    @books = Book.all
    erb :'books/books'
  end


  get "/:id" do
    id = params[:id].to_i
    @book = Book.find id
    erb :'books/view'
  end


  post '/' do
    id = params[:id].to_i
    title = params[:title].to_s
    body = params[:body].to_s
    Book.add id, title, body
    redirect "/"
  end

  get '/:id/edit' do
    id = params[:id].to_i
    @book = Book.find id
    erb :'books/edit'
  end


  put '/:id' do
    id = params[:id].to_i
    title = params[:title].to_s
    body = params[:body].to_s
    Book.edit id, title, body
    redirect "/"
  end

  delete '/:id' do
    id = params[:id].to_i
    Book.delete id
    redirect "/"
  end

end
