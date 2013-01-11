module Hadean
  module TestHelpers

    def create_admin_user(args = {})
      @auusseerr = FactoryGirl.create(:user, args)
      #@auusseerr.stubs(:admin?).returns(true)
      #@uusseerr.stubs(:super_admin?).returns(false)
      @auusseerr.stubs(:roles).returns([Role.find_by_name(Role::ADMIN)])
      @auusseerr
    end
    def create_super_admin_user(args = {})
      @uusseerr = FactoryGirl.create(:user, args)
      #@uusseerr.stubs(:admin?).returns(true)
      #@uusseerr.stubs(:super_admin?).returns(false)
      @uusseerr.stubs(:roles).returns([Role.find_by_name(Role::SUPER_ADMIN)])
      @uusseerr
    end

    def login_as(user)
      #activate_authlogic
      user_session_for user

      #u ||= create(user)
      controller.stubs(:current_user).returns(user)
      #u
    end

    def user_session_for(user)
      UserSession.create(user)
    end

    #def current_user
    #  UserSession.find.user
    #end

    def set_current_user(user = create(:user))
      UserSession.create(user)
      controller.stubs(:current_user).returns(user)
    end

    def create_cart(customer, admin_user = nil, variants = [])
      user = admin_user || customer
      test_cart = Cart.create(:user_id => user.id, :customer_id => customer.id)

      variants.each do |variant|
        test_cart.add_variant(variant.id, customer)
      end

      @controller.stubs(:session_cart).returns(test_cart)
    end
    #def admin_role
    #  role_by_name Role::ADMIN
    #end
    #
    #def role_by_name name
    #  Role.find_by_name name
    #end
  end
end