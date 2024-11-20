# Consumer Challenge
This project consists of two separate applications: a backend API built with Ruby on Rails (consumer_api) and a frontend interface built with React (consumer-ui). Each application is structured in its own directory within this repository for easy navigation and setup.

### Project Structure
```bash
consumer_challenge/
├── consumer_api/    # Backend API built with Ruby on Rails
├── consumer-ui/     # Frontend interface built with React
└── README.md        # Main README with general instructions
```

### Naming Conventions
Each application follows the naming conventions typical to the framework it’s built with:

#### Backend - consumer_api:
The Ruby on Rails community typically uses snake_case for naming directories and files. This is why we’ve named the backend folder consumer_api to maintain alignment with Rails conventions.

#### Frontend - consumer-ui:
React projects commonly use kebab-case for directory names, especially in frontend ecosystems. Thus, we have named the frontend folder consumer-ui in accordance with common practices in JavaScript and React communities.

### Why These Conventions?
* Framework Familiarity: Each naming convention aligns with the standards of its respective framework, making the codebase more intuitive and readable for developers familiar with each technology.
* Consistency and Best Practices: Following standard naming practices improves consistency and maintains industry standards, which is beneficial for team collaboration and future maintenance.

# API Documentation
For more details on how to use the backend API, including pagination and other endpoints, refer to the [API README](https://github.com/thiagomrvieira/consumer-challenge/tree/main/consumer_api#readme)

# TODO
Here are the features and tasks that are still pending implementation:

### API
* Filter: Implement the filtering functionality in the API for products based on various attributes (e.g., brand, price, product_id).
* Improve Data Import System with Sidekiq: Enhance the data import process by integrating Sidekiq for better background job handling.

### UI
* Implementation: Develop the frontend UI for displaying and interacting with the products, utilizing the API for fetching and filtering data.
