require 'rails_helper'

RSpec.describe RecipesController, type: :controller do

  describe '#index' do
    render_views

    before(:each) do
      sign_in FactoryGirl.create(:user_with_recipe)
    end

    let!(:recipe) { FactoryGirl.create :recipe }

    it 'has an add button' do
      get :index

      expect(response.body).to have_css '.add-button'
    end

    it 'shows all recipes' do
      get :index

      expect(response.body).to have_text 'Mini Bakewells'
    end

  end

  describe '#new' do
    render_views

    before(:each) do
      sign_in FactoryGirl.create(:user)
    end

    it 'has a title' do
      get :new

      expect(response.body).to have_text('What would you like to call your recipe?')
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

      it 'has a field to enter amount unit of measurement' do
        get :new

        expect(response.body).to have_css('select#recipe_ingredients_attributes_0_amount_unit_of_measurement')
      end

      it 'has a field to enter size unit of measurement' do
        get :new

        expect(response.body).to have_css('select#recipe_ingredients_attributes_0_size_unit_of_measurement')
      end

    end

  end

  describe '#create' do
    render_views

    before(:each) do
      sign_in FactoryGirl.create(:user)
    end

    let(:params) do
      {
        recipe: {
          name: 'Mini Bakewells',
          ingredients_attributes: {"0": { name: 'Sugar', amount: 100, price: 2.50, size: 100, amount_unit_of_measurement: 'g', size_unit_of_measurement: 'g' }},
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

        expect(response).to redirect_to recipe_path(1)
      end

    end

    context 'invalid data' do

      describe 'when recipe name is missing' do

        before do
          params[:recipe][:name] = nil
        end

        it 'does NOT create a recipe' do
          expect {
            post :create, params: params
          }.to_not change(Recipe, :count)
        end

        it 'shows validation errors' do
          post :create, params: params

          expect(response.body).to have_text('Please fill in all fields')
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

          expect(response.body).to have_text('Please fill in all fields')
        end

        it 'renders new' do
          post :create, params: params

          expect(response).to render_template :new
        end

      end
    end

  end

  describe '#show' do
    render_views

    before(:each) do
      sign_in FactoryGirl.create(:user)
    end

    let!(:recipe) { FactoryGirl.create :recipe_with_ingredients, user_id: 1 }

    it 'displays the recipe name' do
      get :show, params: {id: recipe, user_id: 1}

      expect(response.body).to have_text('Mini Bakewells')
    end

    context 'ingredient' do

      it 'displays the name' do
        get :show, params: {id: recipe}

        expect(response.body).to have_text('Sugar')
      end

      it 'displays the quantity' do
        get :show, params: {id: recipe}

        expect(response.body).to have_text('200g')
      end

      it 'displays the recipe cost' do
        get :show, params: {id: recipe}

        expect(response.body).to have_text('£3.07')
      end
    end

  end

  describe '#destroy' do
    render_views

    before(:each) do
      sign_in FactoryGirl.create(:user)
    end

    let!(:recipe) { FactoryGirl.create :recipe_with_ingredients, user_id: 1 }

    it 'destroys the recipe' do
      expect{delete :destroy, params: { id: recipe, user_id: 1 }}.to change(Recipe, :count).by(-1)
    end

    it 'redirects to the recipe index' do
      delete :destroy, params: { id: recipe, user_id: 1 }

      expect(response).to redirect_to(recipes_path)
    end

    it 'displays a flash message' do
      delete :destroy, params: { id: recipe }

      expect(flash[:notice]).to match(/^Recipe successfully deleted/)
    end

  end

  describe '#update' do
    before(:each) do
      sign_in FactoryGirl.create(:user)
    end

    let!(:recipe) { FactoryGirl.create :recipe_with_ingredients, user_id: 1 }

    xit 'locates the requested recipe' do
      process :update, method: :post, params: { id: recipe, user_id: 1 }

      expect(assigns(:recipe_with_ingredients)).to eq(recipe)
    end

    it 'changes the recipes attributes' do
      put :update, params: { id: recipe, user_id: 1,
        recipe: FactoryGirl.attributes_for(:recipe,  
          name: "Chocolate") }
      recipe.reload
      expect(recipe.name).to eq("Chocolate")
    end

  end

end
