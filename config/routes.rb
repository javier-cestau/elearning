Rails.application.routes.draw do




  devise_for :users,:controllers => { :omniauth_callbacks => "users/omniauth_callbacks"  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  namespace :admin do
    get '/' => redirect('admin/talents')
    get "redaction", to: "tests#redaction"
    get "true_false", to: "tests#true_false"
    get "multiple", to: "tests#multiple"
    get "simple", to: "tests#simple"

    get 'system/settings'
    get 'system/backup'
    get 'system/restore'

    resources :talents do
        resources :talent_progress,as: 'progresses', only: [] do
          collection do
            get '/', to: 'talents#talent_progress'
            get 'approved_courses_general', as: "approved_courses_general", to: 'talents#approved_courses_general'
            get 'approved_courses_by_department', to: 'talents#approved_courses_by_department'
            get 'reprobed_courses_general', to: 'talents#reprobed_courses_general'
            get 'reprobed_courses_by_department', to: 'talents#reprobed_courses_by_department'
            get 'finished_courses_general', to: 'talents#finished_courses_general'
            get 'finished_courses_by_department', to: 'talents#finished_courses_by_department'
            get 'enrolled_courses_general', to: 'talents#enrolled_courses_general'
            get 'enrolled_courses_by_department', to: 'talents#enrolled_courses_by_department'
            get 'favorite_courses_general', to: 'talents#favorite_courses_general'
            get 'categories_talent', to: 'talents#categories_talent'
          end
        end

      resources  :courses, only: [:show] do
          get 'certificate', to: "talents#certificate", defaults: { format: 'pdf' }
      end
      resources :templates , only: [:show]
      get 'templates'

      collection do
          get 'change_state'
      end

    end

    # Esta ruta es para en el caso de que si haya hecho render en POST 'talents'
    # Y se quiera recargar la pagina lo se redireccione a la pagina de registration

    resources :templates, only: [:new, :index, :create] do
      collection do
        get 'choises'
      end
    end

    resources :departments, except: [:destroy]
    resources :categories
    resources :courses, except: [:destroy] do
      get 'talent_list', to: 'courses#talent_list', as:'talent_list'
      resources :multimedia_courses, only: [:create, :destroy]
      resources :sections do
        resources :multimedia_sections , only: [:create, :destroy]
        resources :section_files, only: [:create, :destroy]
        resources :tests do
          get 'average', to: 'tests#average', as: 'average'
          get 'change_auto', to: 'tests#change_auto', as: 'auto'
        end

      end
      collection do
          get 'departments'
          get 'categories'
          get 'users'
          get 'report', to: "courses#report"
          get 'enroll_by_month',to: "reports#enroll_by_month"
          get 'enroll_by_week',to: "reports#enroll_by_week"
          get 'enroll_by_day',to: "reports#enroll_by_day"
      end
    end

    get 'search/courses'
    get 'search/talents'
    get 'search/template'
  end #End admins routes



  get "/talent/:id/notifications", to: "talents#notifications_user"
  resource :talent, only: [] do
    member do
      patch "profile", to: 'talents#update'
    end
    collection do
      get "notification/:id", to: "talents#notifications_readed"
      get "favorites_list", to: 'talents#favorites_list'
      get "profile", to: 'talents#profile'
    end
  end


  resources :courses, only: [:index,:show] do


    get 'grades/:id', to: 'courses#grades', as: 'grades'
    collection do
      get ':id/enroll',  to: "courses#enroll", as: "enroll"
      get ':id/recomendation',  to: "courses#recomendation"
      get ':id/favorite', to: "courses#favorite"
    end
    resources :sections , only: [:show] do
      resources :comment_sections
      resources :tests, only: [:show] do
        member do
           post 'check_answer'
        end
        get 'result/:id', to: "tests#result", as: 'result'
      end
    end

    resources :comment_courses
  end



  resources :template , only: [:show] do
    post 'responses'
  end


  resources :profiles, except: [:destroy,:index,:show, :edit]
  get "profile", to: "profiles#show"
  get "profiles/edit", to: "profiles#edit"

  mount ActionCable.server, at: '/cable'
end
