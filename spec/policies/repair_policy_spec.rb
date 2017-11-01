# frozen_string_literal: true

require "rails_helper"

describe RepairPolicy do
  let(:policy) { described_class.new user, record }
  let(:subject) { policy }
  let(:record) { nil }
  let(:admin_user) { create :admin_user }
  let(:regular_user) { create :user }

  context "new? action" do
    let(:record) { Repair.new }
    let(:action) { :new }

    context "for the admin role" do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context "for the non admin role" do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }
    end
  end

  context "create? action" do
    let(:record) { Repair.new }
    let(:action) { :create }

    context "for the admin role" do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context "for the non admin role" do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }
    end
  end

  context "update? action" do
    let(:record) { create :repair }
    let(:action) { :update }

    context "for the admin role" do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context "for the non admin role" do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }

      context "allowed if it is assigned to the user" do
        let(:record) { create :repair, user: user }

        it { is_expected.to permit_action(action) }
      end
    end
  end

  context "show? action" do
    let(:record) { create :repair }
    let(:action) { :show }

    context "for the admin role" do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context "for the non admin role" do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }

      context "permit if it is assigned to the user" do
        let(:record) { create :repair, user: user }

        it { is_expected.to permit_action(action) }
      end
    end
  end

  context "edit? action" do
    let(:record) { create :repair }
    let(:action) { :edit }

    context "for the admin role" do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context "for the non admin role" do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }

      context "it is allowed if it is assigned to the user" do
        let(:record) { create :repair, user: user }

        it { is_expected.to permit_action(action) }
      end
    end
  end

  context "destroy? action" do
    let(:record) { create :repair }
    let(:action) { :destroy }

    context "for the admin role" do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context "for the non admin role" do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }
    end
  end

  context "index? action" do
    let(:record) { create :repair }
    let(:action) { :index }

    context "for the admin role" do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context "for the non admin role" do
      let(:user) { regular_user }

      it { is_expected.to permit_action(action) }
    end
  end

  context "complete? action" do
    let(:record) { create :repair }
    let(:action) { :complete }

    context "for the admin role" do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context "for the non admin role" do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }

      context "it is allowed if it is assigned to the user" do
        let(:record) { create :repair, user: user }

        it { is_expected.to permit_action(action) }
      end
    end
  end

  context "uncomplete? action" do
    let(:record) { create :repair }
    let(:action) { :uncomplete }

    context "for the admin role" do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context "for the non admin role" do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }
    end
  end

  context "approve? action" do
    let(:record) { create :repair }
    let(:action) { :approve }

    context "for the admin role" do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context "for the non admin role" do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }
    end
  end

  context "assign_user? action" do
    let(:record) { create :repair }
    let(:action) { :assign_user }

    context "for the admin role" do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context "for the non admin role" do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }
    end
  end
end
