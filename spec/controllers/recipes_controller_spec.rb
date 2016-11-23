require 'rails_helper'

RSpec.describe RecipesController, type: :controller do

  describe '#index' do
    render_views

    let!(:recipe) { FactoryGirl.create :recipe }

    it 'has a title' do
      get :index

      expect(response.body).to have_text('Recipes')
    end

    it 'has an add button' do
      get :index

      expect(response.body).to have_css '.add-button', text: 'Add new recipe'
    end

    it 'shows all recipes' do
      get :index

      expect(response.body).to have_text 'Mini Bakewells'
    end

  end

  describe '#new' do
    render_views

    it 'has a title' do
      get :new

      expect(response.body).to have_text('Add new recipe')
    end

    it 'has an input box to enter a title' do
      get :new
      
      expect(response.body).to have_css('input#recipe_name')
    end

    it 'has an input box to enter a title' do
      get :new

      expect(response.body).to have_css('input#recipe_ingredients_attributes_0_name')
    end

  end

  describe '#create' do
    render_views

    let(:params) do
      {
        recipe: {
          name: 'Mini Bakewells'
        }
      }
    end

    context 'happy path' do

      it 'creates a recipe' do
        expect {
          post :create, params: params
        }.to change(Recipe, :count).from(0).to(1)
      end

      it 'redirects to recipe show page' do
        post :create, params: params

        expect(response).to redirect_to recipe_path(5)
      end

    end

    context 'invalid data' do

      describe 'when name is missing' do

        before do
          params[:recipe][:name] = nil
        end

        it 'does not create a recipe' do
          expect {
            post :create, params: params
          }.to_not change(Recipe, :count)
        end

        it 'shows validation errors' do
          post :create, params: params

          expect(response.body).to have_text('Please fill in a title')
        end

        it 'renders new' do
          post :create, params: params

          expect(response).to render_template :new
        end

      end
    end

    describe '#show' do
      render_views

      let!(:recipe) { FactoryGirl.create :recipe }

      it 'displays the recipe name' do
        get :show, params: {id: recipe}

        expect(response.body).to have_text('Mini Bakewells')
      end
    end

  end

end
