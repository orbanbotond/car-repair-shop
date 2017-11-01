require 'rails_helper'

describe UserPolicy do
  let(:policy) { described_class.new user, record }
  let(:subject) { policy }
  let(:record) { nil }

  context 'new? action' do
    let(:record) { User.new }

    context 'for the admin role' do
      let(:user) { create :admin_user }

      it { is_expected.to be_able_to(:new) }
    end

    context 'for the non admin role' do
      let(:user) { create :user }

      it { is_expected.to_not be_able_to(:new) }
    end
  end

  context 'create? action' do
    let(:record) { User.new }

    context 'for the admin role' do
      let(:user) { create :admin_user }

      it { is_expected.to be_able_to(:create) }
    end

    context 'for the non admin role' do
      let(:user) { create :user }

      it { is_expected.to_not be_able_to(:create) }
    end
  end

  context 'update? action' do
    let(:record) { create :user }

    context 'for the admin role' do
      let(:user) { create :admin_user }

      it { is_expected.to be_able_to(:update) }
    end

    context 'for the non admin role' do
      let(:user) { create :user }

      it { is_expected.to_not be_able_to(:update) }
    end
  end

  context 'show? action' do
    let(:record) { create :user }

    context 'for the admin role' do
      let(:user) { create :admin_user }

      it { is_expected.to be_able_to(:show) }
    end

    context 'for the non admin role' do
      let(:user) { create :user }

      it { is_expected.to_not be_able_to(:show) }
    end
  end

  context 'edit? action' do
    let(:record) { create :user }

    context 'for the admin role' do
      let(:user) { create :admin_user }

      it { is_expected.to be_able_to(:edit) }
    end

    context 'for the non admin role' do
      let(:user) { create :user }

      it { is_expected.to_not be_able_to(:edit) }
    end
  end


  context 'destroy? action' do
    let(:record) { create :user }

    context 'for the admin role' do
      let(:user) { create :admin_user }

      it { is_expected.to be_able_to(:destroy) }

      context 'trying to destroy ourselves' do
        let(:record) { user }

        it { is_expected.to_not be_able_to(:destroy) }
      end
    end

    context 'for the non admin role' do
      let(:user) { create :user }

      it { is_expected.to_not be_able_to(:destroy) }
    end
  end

  context 'index? action' do
    let(:record) { create :user }

    context 'for the admin role' do
      let(:user) { create :admin_user }

      it { is_expected.to be_able_to(:index) }
    end

    context 'for the non admin role' do
      let(:user) { create :user }

      it { is_expected.to_not be_able_to(:index) }
    end
  end

end
