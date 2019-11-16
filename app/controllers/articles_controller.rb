class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id]) # Article.find để tìm article tương ứng với :id param, đồng thời chúng ta sử dụng 1 instance variale với prefix là @ để lưu tham chiếu đến article obj mà chúng ta muốn hiển thị. Rails sẽ pass tất cả các instance var ra view
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    # render plain: params[:article].inspect
    # params[:article] chính là scope của form. 1 trang có thể có nhiều form, sử dụng scope sẽ bao đóng được form mà chúng ta đang muốn lấy dữ liệu

    @article = Article.new(article_params) # Mỗi 1 rails model sẽ được khởi tạo với attr tương ứng được mapped với db column tương ứng. Dòng lệnh này thực hiện điều này (params[:article] là những attr mà chúng ta đang quan tâm). .permit(:title, :text) để cho biết những field nào sẽ được đưa vào db. Để đảm bảo tính bao đóng và bảo mật.
    # @article.save Đơn giản là save model vào trong db. Lệnh này sẽ trả về true hoặc false tương ứng với việc article có được save hay không.
    if @article.save
      redirect_to @article
      # Nếu validation trả về true thì render ra article_path, với data được truyền ra view là @article
    else
      render "new"
      # render ra template new nếu validaton sai
    end
  end

  def update
    @article = Article.find(params[:id]) 
    
    # method update là method chúng ta sử dụng khi muốn update 1 record nào đó đã tồn tại. Và nó chấp nhận những hash attr mà chúng ta muốn update. Chúng ta cũng rẽ nhánh điều kiện để validate data như đối với edit
    if @article.update(article_params)
      redirect_to @article
    else
      render @article
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  # Các private method phải được đặt ở cuối trong controller
  private

  def article_params
    params.require(:article).permit(:title, :text) # Chúng ta sẽ sử dụng private article_params để đảm bảo nó sẽ chỉ được call ở bên trong controller mà thôi.
  end
end
