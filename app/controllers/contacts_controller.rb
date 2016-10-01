class ContactsController < ApplicationController
  def new
    if params[:back]
      @contact = Contact.new(contacts_params)
    else
      @contact = Contact.new
    end
  end
  
  def create
  @contact = Contact.new(contacts_params)
    if @contact.save
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to contacts_path, notice: "お問い合わせありがとうございました！"
      NoticeMailer.sendmail_contact(@contact).deliver
    else
      # 入力フォームを再描画します。
      render action: 'new'
    end
  end
  
  def confirm
   @contact = Contact.new(contacts_params)
   render :new if @contact.invalid?
  end
  
    private
    def contacts_params
      params.require(:contact).permit(:title, :content, :email)
    end
end
