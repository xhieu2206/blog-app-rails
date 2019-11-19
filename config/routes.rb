Rails.application.routes.draw do
  get 'welcome/index'
  resources :articles do # Method do rails cung cấp
    resources :comments
  end
  root 'welcome#index' # Sẽ nói với Rails map request tới root của app, tới welcome controller, tức là nếu root của url không có gì nó sẽ được map đến hành động của welcome#index
end
