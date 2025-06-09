Navegation:

SmartCapital/
├── App/
│ └── SmartCapitalApp.swift # Ponto de entrada do app
│
├── Components/
│ ├── FlexibleTagGrid.swift # Componente para exibição dinâmica de tags
│ └── PrimaryButton.swift # Botão customizado reutilizável
│
├── Features/
│ ├── AIRecommendations/
│ │ ├── Models/
│ │ │ └── Recommendation.swift # Modelo de recomendação de notícias por IA
│ │ ├── ViewModels/
│ │ │ └── AIRecommendationsViewModel.swift # Lógica de negócios das recomendações
│ │ └── Views/
│ │ └── AIRecommendationView.swift # Tela de recomendações por IA
│ │
│ └── Auth/
│ ├── Models/
│ │ └── AuthUser.swift # Modelo do usuário autenticado
│ ├── ViewModels/
│ │ └── AuthViewModel.swift # Lógica de autenticação
│ └── Views/
│ ├── AuthLoadingView.swift # Splash/loading da autenticação
│ ├── LoginView.swift # Tela de login
│ └── SignUpView.swift # Tela de cadastro
│
├── Home/ # Funcionalidades da tela principal (feed de notícias)
├── News/ # Tela de detalhes de notícias e curadoria
├── Onboarding/ # Primeira experiência e configurações iniciais
│
├── Resources/
│ └── Assets/ # Ícones, imagens e cores do projeto
│
├── Shared/
│ └── Network/
│ └── SupabaseManager.swift # Serviço de autenticação e conexão com o Supabase
│
└── Frameworks/ # Bibliotecas externas utilizadas
