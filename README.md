
## 🧭 Estrutura do Projeto

```
SmartCapital/
├── App/
│   └── SmartCapitalApp.swift        # Ponto de entrada do app
│
├── Components/
│   ├── FlexibleTagGrid.swift        # Componente para exibição dinâmica de tags
│   └── PrimaryButton.swift          # Botão customizado reutilizável
│
├── Features/
│   ├── AIRecommendations/
│   │   ├── Models/
│   │   │   └── Recommendation.swift # Modelo de recomendação de notícias por IA
│   │   ├── ViewModels/
│   │   │   └── AIRecommendationsViewModel.swift # Lógica de negócios das recomendações
│   │   └── Views/
│   │       └── AIRecommendationView.swift       # Tela de recomendações por IA
│   │
│   └── Auth/
│       ├── Models/
│       │   └── AuthUser.swift       # Modelo do usuário autenticado
│       ├── ViewModels/
│       │   └── AuthViewModel.swift  # Lógica de autenticação
│       └── Views/
│           ├── AuthLoadingView.swift # Splash/loading da autenticação
│           ├── LoginView.swift       # Tela de login
│           └── SignUpView.swift      # Tela de cadastro
│
├── Home/                            # Funcionalidades da tela principal (feed de notícias)
├── News/                            # Tela de detalhes de notícias e curadoria
├── Onboarding/                      # Primeira experiência e configurações iniciais
│
├── Resources/
│   └── Assets/                      # Ícones, imagens e cores do projeto
│
├── Shared/
│   └── Network/
│       └── SupabaseManager.swift    # Serviço de autenticação e conexão com o Supabase
│
└── Frameworks/                      # Bibliotecas externas utilizadas
```

---

## 🧩 Tecnologias Utilizadas

- **Swift / SwiftUI** – Desenvolvimento iOS moderno e declarativo
- **Supabase** – Autenticação e backend
- **OpenAI / Gemini** – Geração de resumos por IA
- **MongoDB Atlas** – Armazenamento de notícias e usuários
- **Google Cloud Functions** – Coleta automatizada de notícias

---

## 🛠️ Arquitetura

O projeto adota a arquitetura **MVVM modularizada** com separação clara entre camadas de:
- Modelos (Models)
- Lógicas de negócio (ViewModels)
- Interfaces visuais (Views)

Além disso, seguem-se princípios de:
- **SOLID**
- **Clean Code**
- **Padrões de Projeto GoF (Strategy, Singleton, Observer)**

---

## 🔒 Autenticação

Toda a lógica de login/cadastro é gerenciada por `SupabaseManager.swift` via Supabase, com suporte a:
- Login com e-mail/senha
- Manutenção de sessão
- Registro de novo usuário

---

## 🧠 Inteligência Artificial

A pasta `AIRecommendations` integra serviços de curadoria automática utilizando modelos de IA para:
- Recomendar notícias com base no interesse do usuário
- Gerar resumos dinâmicos
- Classificar conteúdo crítico

---

## ✨ Experiência do Usuário

- Interface adaptável (modo claro/escuro)
- Feed personalizado
- Filtros e tags interativas
- Transições fluidas e animações com SwiftUI

---

## 📂 Recursos Futuramente Adicionados

- Notificações push segmentadas
- Sistema de favoritos/salvos
- Perfil e preferências do usuário
- Dashboard de consumo de conteúdo
