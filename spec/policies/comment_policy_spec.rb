# frozen_string_literal: true

require "rails_helper"

describe CommentPolicy do
  let(:policy) { described_class.new user, record }
  let(:subject) { policy }
  let(:record) { nil }
  let(:admin_user) { create :admin_user }
  let(:regular_user) { create :user }
  let(:another_user) { create :user }
  let(:another_repair) { create :repair, user: another_user }
  let(:repair) { create :repair, user: user }

  context "new? action" do
    let(:record) { build :comment }
    let(:action) { :new }

    context "for the admin role" do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context "for the non admin role" do
      let(:user) { regular_user }

      context "on a repair belonging to another user" do
        let(:record) { build :comment, repair: another_repair }
        it { is_expected.to forbid_action(action) }
      end

      context "on a repair belonging to me" do
        let(:record) { build :comment, repair: repair }
        it { is_expected.to permit_action(action) }
      end
    end
  end

  context "create? action" do
    let(:record) { build :comment }
    let(:action) { :create }

    context "for the admin role" do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context "for the non admin role" do
      let(:user) { regular_user }

      context "on a repair belonging to another user" do
        let(:record) { build :comment, repair: another_repair }
        it { is_expected.to forbid_action(action) }
      end

      context "on a repair belonging to me" do
        let(:record) { build :comment, repair: repair }
        it { is_expected.to permit_action(action) }
      end
    end
  end

  context "update? action" do
    let(:record) { create :comment }
    let(:action) { :update }

    context "for the admin role" do
      let(:user) { admin_user }

      it { is_expected.to forbid_action(action) }
    end

    context "for the non admin role" do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }
    end
  end

  context "show? action" do
    let(:record) { create :comment }
    let(:action) { :show }

    context "for the admin role" do
      let(:user) { admin_user }

      it { is_expected.to permit_action(action) }
    end

    context "for the non admin role" do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }
    end
  end

  context "edit? action" do
    let(:record) { create :comment }
    let(:action) { :edit }

    context "for the admin role" do
      let(:user) { admin_user }

      it { is_expected.to forbid_action(action) }
    end

    context "for the non admin role" do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }
    end
  end


  context "destroy? action" do
    let(:record) { create :comment }
    let(:action) { :destroy }

    context "for the admin role" do
      let(:user) { admin_user }

      it { is_expected.to forbid_action(action) }
    end

    context "for the non admin role" do
      let(:user) { regular_user }

      it { is_expected.to forbid_action(action) }
    end
  end

  context "index? action" do
    let(:record) { create :user }
    let(:action) { :index }

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
