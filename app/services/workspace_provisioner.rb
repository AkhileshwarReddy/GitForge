class WorkspaceProvisioner
    def self.provision!(org: , creator: , project_names:)
        Organisation.transaction do
            org.memberships.grant!(creator, level: :owner)
            projects = create_projects(org, project_names, creator)
            pin_first_project(projects)
        end

        {
            pinned_projects: org.pinned_projects,
            owners: org.owners
        }
    end

    private

    def self.create_projects(org, project_names, creator)
        project_names.map do |name|
            org.projects.create!(
                name: name,
                path: name,
                creator: creator,
                repository_config_attributes: {
                    default_branch: "main"
                }
            )
        end
    end

    def self.pin_first_project(projects)
        projects.first.update!(pinned: true)
    end
end
