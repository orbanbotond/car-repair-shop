require 'rails_helper'

describe UserPolicy do
  let(:policy) { described_class.new user, record }
  let(:subject) { policy }
  let(:record) { nil }
  let(:admin_user) { create :admin_user }
  let(:regular_user) { create :user }

  context 'new? action' do
    let(:record) { User.new }

    context 'for the admin role' do
      let(:user) { admin_user }

      it { is_expected.to permit_action(:new) }
    end

    context 'for the non admin role' do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(:new) }
    end
  end

  context 'create? action' do
    let(:record) { User.new }

    context 'for the admin role' do
      let(:user) { admin_user }

      it { is_expected.to permit_action(:create) }
    end

    context 'for the non admin role' do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(:create) }
    end
  end

  context 'update? action' do
    let(:record) { create :user }

    context 'for the admin role' do
      let(:user) { admin_user }

      it { is_expected.to permit_action(:update) }
    end

    context 'for the non admin role' do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(:update) }
    end
  end

  context 'show? action' do
    let(:record) { create :user }

    context 'for the admin role' do
      let(:user) { admin_user }

      it { is_expected.to permit_action(:show) }
    end

    context 'for the non admin role' do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(:show) }

      context 'myself' do
        let(:record) { user }

        it { is_expected.to permit_action(:show) }
      end
    end
  end

  context 'edit? action' do
    let(:record) { create :user }

    context 'for the admin role' do
      let(:user) { admin_user }

      it { is_expected.to permit_action(:edit) }
    end

    context 'for the non admin role' do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(:edit) }
    end
  end


  context 'destroy? action' do
    let(:record) { create :user }

    context 'for the admin role' do
      let(:user) { admin_user }

      it { is_expected.to permit_action(:destroy) }

      context 'trying to destroy ourselves' do
        let(:record) { user }

        it { is_expected.to forbid_action(:destroy) }
      end
    end

    context 'for the non admin role' do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(:destroy) }
    end
  end

  context 'index? action' do
    let(:record) { create :user }

    context 'for the admin role' do
      let(:user) { admin_user }

      it { is_expected.to permit_action(:index) }
    end

    context 'for the non admin role' do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(:index) }
    end
  end

end
