class BlogsController < ApplicationController
  
  def index
    @blogs = Blog.all #全てのブログを取得する処理
  end

  def new #入力画面をつくる
    if params[:back]
      @blog = Blog.new(blogs_params)
    else
      @blog = Blog.new
    end
  end

  def create #入力された情報を保存したりする
    @blog = Blog.new(blogs_params)
    if @blog.save
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to blogs_path, notice: "ブログを作成しました！"
    else
      # 入力フォームを再描画します。
      render action: 'new'
    end
  end

  def edit #編集画面を作る
    @blog = Blog.find(params[:id])
  end
  
  def update #編集する
    @blog = Blog.find(params[:id])
    @blog.update(blogs_params)
    redirect_to blogs_path #redirect_to メソッド
  end
  
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました！" #redirect_to メソッド
  end
  
  def confirm
    @blog = Blog.new(blogs_params)
    render :new if @blog.invalid?
  end
  
  private
    def blogs_params
      params.require(:blog).permit(:title, :content)
    end
    
    # idをキーとして値を取得するメソッド
    def set_blog
      @blog = Blog.find(params[:id])
    end
end