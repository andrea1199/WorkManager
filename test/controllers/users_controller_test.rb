require 'test_helper'
require 'rails-controller-testing'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @admin = users(:admin)
    @dirigente = users(:dirigente)
    sign_in @user
  end

  test 'should get dashboard' do
    get dashboard_url
    assert_response :success
    assert_equal @user, assigns(:user)
  end

  test 'should show selected user info for dirigente' do
    sign_in @dirigente
    selected_user = users(:two)
    get show_selected_user_info_users_url, params: { user_id: selected_user.id }
    assert_response :success
    assert_template 'dirigente/dipendente'
  end

  test 'should show selected user info for admin' do
    sign_in @admin
    selected_user = users(:two)
    get show_selected_user_info_users_url, params: { user_id: selected_user.id }
    assert_response :success
    assert_template 'admin/user_details'
  end

  test 'should redirect unauthorized user from show selected user info' do
    selected_user = users(:two)
    get show_selected_user_info_users_url, params: { user_id: selected_user.id }
    assert_redirected_to root_path
    assert_equal 'Non autorizzato a visualizzare queste informazioni.', flash[:alert]
  end

  test 'should redirect if user not found in show selected user info' do
    get show_selected_user_info_users_url, params: { user_id: 999 }
    assert_redirected_to root_path
    assert_equal 'Utente non trovato.', flash[:alert]
  end

  test 'should update profile with valid attributes' do
    patch update_profile_users_url, params: { user: { nome: 'Nuovo Nome' } }
    assert_redirected_to root_path
    assert_equal 'Profilo aggiornato con successo.', flash[:notice]
    assert_equal 'Nuovo Nome', @user.reload.nome
  end

  test 'should not update profile with invalid attributes' do
    patch update_profile_users_url, params: { user: { email: 'invalid' } }
    assert_template :complete_profile
    assert_equal 'Errore durante l\'aggiornamento del profilo.', flash[:error]
  end

  test 'should promote selected users as admin' do
    sign_in @admin
    dipendente = users(:dipendente)
    post promote_selected_users_url, params: { user_ids: [dipendente.id] }
    assert_redirected_to promote_confirm_users_path
    assert_equal 'dirigente', dipendente.reload.ruolo
  end

  test 'should retrocede selected users as admin' do
    sign_in @admin
    dirigente_user = users(:dirigente)
    post retrocedi_selected_users_url, params: { user_ids: [dirigente_user.id] }
    assert_redirected_to retrocedi_confirm_users_path
    assert_equal 'dipendente', dirigente_user.reload.ruolo
  end
end
