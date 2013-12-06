require "test_helper"

class LineItemsControllerTest < ActionController::TestCase

  before do
    @line_item = line_items(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    create_valid_item
    assert_difference('LineItem.count') do
      post :create, :item_id => @item.id
    end

    assert_redirected_to cart_path(assigns(:line_item).cart)
  end

  def test_show
    get :show, id: @line_item
    assert_response :success
  end

  def test_edit
    get :edit, id: @line_item
    assert_response :success
  end

  def test_update
    put :update, id: @line_item, line_item: {  }
    assert_redirected_to line_item_path(assigns(:line_item))
  end

  def test_destroy
    assert_difference('LineItem.count', -1) do
      delete :destroy, id: @line_item
    end

    assert_redirected_to line_items_path
  end
end
