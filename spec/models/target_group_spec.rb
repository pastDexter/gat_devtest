require 'rails_helper'

describe TargetGroup, type: :model do

  describe '#root?' do
    it 'returns true when target group has no parent' do
      subject.parent_id = nil
      expect(subject).to be_root
    end
    it 'returns false when target group has a parent' do
      subject.parent_id = 1
      expect(subject).not_to be_root
    end
  end

  describe '.find_roots_with_children' do
    let(:panel_provider) { create(:panel_provider) }
    let(:country) { create(:country, panel_provider: panel_provider) }
    let(:root) { create(:target_group, countries: [country], panel_provider: panel_provider) }
    let!(:children_l1) { create_list(:target_group, 2, parent: root) }
    let!(:children_l2) { create_list(:target_group, 2, parent: children_l1.first) }

    context 'without filtering' do
      it 'returns all target groups' do
        expect(TargetGroup.find_roots_with_children.size).to eq TargetGroup.count
      end
    end

    context 'with filtering' do
      let(:other_country) { create(:country) }
      before { create(:target_group, countries: [other_country], panel_provider: panel_provider) }

      it 'returns only matching root group with its children' do
        target_groups = country.target_groups.find_roots_with_children
        expect(target_groups).to contain_exactly(root, *children_l1, *children_l2)
      end
    end
  end
end
