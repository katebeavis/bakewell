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

    it 'has a field to enter a title' do
      get :new
      
      expect(response.body).to have_css('input#recipe_name')
    end

    context 'ingredients' do

      it 'has a field to enter name' do
        get :new

        expect(response.body).to have_css('input#recipe_ingredients_attributes_0_name')
      end

      it 'has a field to enter quanity' do
        get :new

        expect(response.body).to have_css('input#recipe_ingredients_attributes_0_name')
      end

      it 'has a field to enter amount' do
        get :new

        expect(response.body).to have_css('input#recipe_ingredients_attributes_0_amount')
      end

      it 'has a field to enter price' do
        get :new

        expect(response.body).to have_css('input#recipe_ingredients_attributes_0_price')
      end

      it 'has a field to enter size' do
        get :new

        expect(response.body).to have_css('input#recipe_ingredients_attributes_0_size')
      end

    end

  end

  describe '#create' do
    render_views

    let(:params) do
      {
        recipe: {
          name: 'Mini Bakewells',
          ingredients_attributes: {"0": { name: 'Sugar', amount: 100, price: 2.50, size: 100 }},
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

      describe 'when recipe name is missing' do

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

      describe 'when ingredient name is missing' do

        before do
          params[:recipe][:ingredients_attributes][:"0"][:name] = nil
        end

        it 'does not create a recipe' do
          expect {
            post :create, params: params
          }.to_not change(Recipe, :count)
        end

        it 'shows validation errors' do
          post :create, params: params

          expect(response.body).to have_text('can\'t be blank')
        end

        it 'renders new' do
          post :create, params: params

          expect(response).to render_template :new
        end

      end
    end

    describe '#show' do
      render_views

      let!(:recipe) { FactoryGirl.create :recipe_with_ingredients }

      it 'displays the recipe name' do
        get :show, params: {id: recipe}

        expect(response.body).to have_text('Mini Bakewells')
      end

      context 'ingredient' do

        it 'displays the name' do
          get :show, params: {id: recipe}

          expect(response.body).to have_text('Sugar')
        end

        it 'displays the quantity' do
          get :show, params: {id: recipe}

          expect(response.body).to have_text('100')
        end

        it 'displays the price' do
          get :show, params: {id: recipe}
          
          expect(response.body).to have_text('£2.50')
        end

        it 'displays the size' do
          get :show, params: {id: recipe}

          expect(response.body).to have_text('100')
        end

        it 'displays the cost' do
          get :show, params: {id: recipe}

          expect(response.body).to have_text('£2.50')
        end
      end

    end

  end

end
