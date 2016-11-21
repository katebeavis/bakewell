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

    it 'creates a recipe' do
      expect {
        post :create, params: params
      }.to change(Recipe, :count).from(0).to(1)
    end

  end

end
