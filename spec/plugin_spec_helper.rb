module Terms
  module PluginSpecHelper
    def disable_flash_sweep
      @controller.instance_eval { flash.stub!(:sweep) }
    end

    def define_and_accept_terms_for(project, user)
      terms = define_terms_for(project)

      user.accept_project_terms!(project,
                                 terms.wiki_content.id,
                                 terms.wiki_content.lock_version)

      terms
    end

    def define_terms_for(project)
      project_with_wiki(project)

      terms = Factory.create(:project_terms, :project => project,
                                             :wiki_content => project.wiki.pages.first.content)
      terms.reload
    end

    def is_member(project, user, permissions = [])
      role = Factory.create(:role, :permissions => permissions)

      Factory.create(:member, :project => project,
                              :principal => user,
                              :roles => [role])
    end

    def define_global_terms
      project = project_with_wiki

      Setting.plugin_terms = { "global_terms_project" => project.id.to_s,
                               "global_terms_wiki_page" => project.wiki.pages.first.title }

      project.wiki.pages.first.content
    end

    def define_and_accept_global_terms user
      content = define_global_terms

      bob.accept_global_terms!(content.id, content.lock_version)

      content
    end

    private

    def project_with_wiki(project = nil)
      if project
        project.save!
      else
        project = Factory.create(:project)
      end

      project.wiki = Factory.create(:wiki, :project => project)
      project.wiki.pages << Factory.create(:wiki_page, :wiki => project.wiki)
      project.wiki.pages.first.content = Factory.create(:wiki_content, :page => project.wiki.pages.first)

      project
    end
  end
end
