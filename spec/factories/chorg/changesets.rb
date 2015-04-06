FactoryGirl.define do
  factory :add_changeset, class: Chorg::Changeset do
    type Chorg::Changeset::TYPE_ADD
    destinations { [ { name: "シラサギ市/新設グループ_#{unique_id}" }.stringify_keys ] }
  end

  factory :move_changeset, class: Chorg::Changeset do
    transient do
      source nil
    end

    type Chorg::Changeset::TYPE_MOVE
    sources { [ { id: source.id, name: source.name }.stringify_keys ] }
    destinations do
      [ { name: "シラサギ市/新設グループ_#{unique_id}",
          contact_email: "mb4pjr0czv@example.jp",
          contact_tel: "03-8471-8438",
          contact_fax: "03-8471-8439" }.stringify_keys ]
    end
  end

  factory :unify_changeset, class: Chorg::Changeset do
    transient do
      sources nil
      destination nil
    end

    type Chorg::Changeset::TYPE_UNIFY
    destinations do
      [ { name: "シラサギ市/新設グループ_#{unique_id}",
          contact_email: "mb4pjr0czv@example.jp",
          contact_tel: "03-8471-8438",
          contact_fax: "03-8471-8439" }.stringify_keys ]
    end

    after(:build) do |entity, evaluator|
      entity.sources = evaluator.sources.map do |group|
        { id: group.id, name: group.name }.stringify_keys
      end.to_a
      if evaluator.destination.present?
        entity.destinations = [ { name: evaluator.destination.name,
                           contact_email: evaluator.destination.contact_email,
                           contact_tel: evaluator.destination.contact_tel,
                           contact_fax: evaluator.destination.contact_fax }.stringify_keys ]
      end
    end
  end

  factory :division_changeset, class: Chorg::Changeset do
    transient do
      source nil
      destinations nil
    end

    type Chorg::Changeset::TYPE_DIVISION
    sources { [ { id: source.id, name: source.name }.stringify_keys ] }

    after(:build) do |entity, evaluator|
      entity.destinations = evaluator.destinations.map do |group|
        { name: group.name,
          contact_email: group.contact_email,
          contact_tel: group.contact_tel,
          contact_fax: group.contact_fax }.stringify_keys
      end.to_a
    end
  end

  factory :delete_changeset, class: Chorg::Changeset do
    transient do
      source nil
    end

    type Chorg::Changeset::TYPE_DELETE
    sources { [ { id: source.id, name: source.name }.stringify_keys ] }
  end
end
