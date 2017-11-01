require 'rails_helper'

describe UserPolicy do
  let(:policy) { described_class.new user, record }
  let(:subject) { policy }
  let(:record) { nil }
  let(:admin_user) { create :admin_user }
  let(:regular_user) { create :user }

  context 'new? action' do
    let(:record) { User.new }
    let(:action) { :new }

    context 'for the admin role' do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context 'for the non admin role' do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }
    end
  end

  context 'create? action' do
    let(:record) { User.new }
    let(:action) { :create }

    context 'for the admin role' do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context 'for the non admin role' do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }
    end
  end

  context 'update? action' do
    let(:record) { create :user }
    let(:action) { :update }

    context 'for the admin role' do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context 'for the non admin role' do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }
    end
  end

  context 'show? action' do
    let(:record) { create :user }
    let(:action) { :show }

    context 'for the admin role' do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context 'for the non admin role' do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }

      context 'myself' do
        let(:record) { user }

        it { is_expected.to permit_action(action) }
      end
    end
  end

  context 'edit? action' do
    let(:record) { create :user }
    let(:action) { :edit }

    context 'for the admin role' do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context 'for the non admin role' do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }
    end
  end


  context 'destroy? action' do
    let(:record) { create :user }
    let(:action) { :destroy }

    context 'for the admin role' do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }

      context 'trying to destroy ourselves' do
        let(:record) { user }

        it { is_expected.to forbid_action(action) }
      end
    end

    context 'for the non admin role' do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }
    end
  end

  context 'index? action' do
    let(:record) { create :user }
    let(:action) { :index }

    context 'for the admin role' do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context 'for the non admin role' do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }
    end
  end
end
