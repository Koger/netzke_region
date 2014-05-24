class Application < Netzke::Basepack::Viewport

  # A simple mockup of the User model
  class User < Struct.new(:email, :password)
    def initialize
      self.email = "demo@netzke.org"
      self.password = "netzke"
    end
    def self.authenticate_with?(email, password)
      instance = self.new
      [email, password] == [instance.email, instance.password]
    end
  end

  action :about do |c|
    c.icon = :information
  end

  action :sign_in do |c|
    c.icon = :door_in
  end

  action :sign_out do |c|
    c.icon = :door_out
    c.text = "Sign out #{current_user.email}" if current_user
  end

  js_configure do |c|
    c.layout = :fit
    c.mixin
  end

  def configure(c)
    super
    c.intro_html = "Click on a demo component in the navigation tree"
    c.items = [
      { layout: :border,
        tbar: [header_html, '->', :about, current_user ? :sign_out : :sign_in],
        items: [
          { region: :west, item_id: :navigation, width: 300, split: true, xtype: :treepanel, root: menu, root_visible: false, title: "Навигация ()" },
          { region: :center, layout: :border, border: false, items: [
            { item_id: :info_panel, region: :north, height: 35, body_padding: 5, split: true, html: initial_html },
            { item_id: :main_panel, region: :center, layout: :fit, border: false, items: [{body_padding: 5, html: "Components will be loaded in this area"}] } # items is only needed here for cosmetic reasons (initial border)
          ]}
        ]
      }
    ]
  end

  #
  # Components
  #

  component :cmps do |c|
    c.desc = "A grid configured with just a model. " + source_code_link(c)
  end

  component :cmp_speciality_grid do |c|
    c.desc = "A grid with customized columns. " + source_code_link(c)
  end

  component :diplom_topic_grid do |c|
    c.desc = "Columns size, order, and hidden status will be remembered for this grid - play with that! " + source_code_link(c)
  end

  component :depts do |c|
    c.desc = "A grid where you can delet rows by clicking a column action. Uses <a href='https://github.com/netzke/netzke-communitypack'>netzke-communitypack</a>. " + source_code_link(c)
  end

  component :district_grid do |c|
    c.desc = "A grid where you can delet rows by clicking a column action. Uses <a href='https://github.com/netzke/netzke-communitypack'>netzke-communitypack</a>. " + source_code_link(c)
  end

  component :village_grid do |c|
    c.desc = "A grid where you can delet rows by clicking a column action. Uses <a href='https://github.com/netzke/netzke-communitypack'>netzke-communitypack</a>. " + source_code_link(c)
  end

  component :reviewer_grid do |c|
    c.title  = "Рецензенты"
  end

  #
  # Composite components
  #

  component :bosses_and_clerks do |c|
    c.title  = "Bosses and Clerks"
    c.desc = "A compound component from #{link("this", "https://github.com/netzke/netzke/wiki/Building-a-composite-component")} tutorial. The component is a sample implementation of the one-to-many relationship UI. " + source_code_link(c)
  end

  component :static_tab_panel do |c|
    c.desc = "A TabPanel with pre-loaded tabs (as opposed to dynamically loaded components). " + source_code_link(c)
  end

  component :dynamic_tab_panel do |c|
    c.desc = "A TabPanel with dynamically loaded tab components. " + source_code_link(c)
  end

  component :static_accordion do |c|
    c.desc = "An Accordion with pre-loaded tabs (as opposed to dynamically loaded components). " + source_code_link(c)
  end

  component :dynamic_accordion do |c|
    c.desc = "An Accordion with dynamically loaded tab components. " + source_code_link(c)
  end

  #component :clerk_inspector do |c|
  #  c.desc = "Clerk and Inspector" + source_code_link(c)
  #end

  component :simple_window do |c|
    c.desc = "A simple window with persistent dimensions, position, and state. " + source_code_link(c)
  end

  component :window_with_grid do |c|
    c.desc = "A window that nests a Grid. #{source_code_link(c)}"
  end

  component :window_nesting_bosses_and_clerks do |c|
    c.desc = "A window that nests a compound component (see the 'Bosses and Clerks' example). #{source_code_link(c)}"
  end

  component :for_authenticated do |c|
    c.klass = Netzke::Core::Panel
    c.desc = "A simple panel that can only be loaded when the user is authenticated. It's defined inline in components/application.rb, there's no separate class for it."
    c.html = "You cannot load this component even by tweaking the URI, because it's configured with authorization in mind."
    c.body_padding = 5
  end

  # Endpoints
  #
  #
  endpoint :sign_in do |params,this|
    user = User.new
    if User.authenticate_with?(params[:email], params[:password])
      session[:user_id] = 1 # anything; this is what you'd normally do in a real-life case
      this.netzke_set_result(true)
    else
      this.netzke_set_result(false)
      this.netzke_feedback("Wrong credentials")
    end
  end

  endpoint :sign_out do |params,this|
    session[:user_id] = nil
    this.netzke_set_result(true)
  end

protected

  def current_user
    @current_user ||= session[:user_id] && User.new
  end

  def link(text, uri)
    "<a href='#{uri}'>#{text}</a>"
  end

  def source_code_link(c)
    comp_file_name = c.klass.nil? ? c.name.underscore : c.klass.name.underscore
    uri = [NetzkeDemo::Application.config.repo_root, "app/components", comp_file_name + '.rb'].join('/')
    "<a href='#{uri}' target='_blank'>Source code</a>"
  end

  def header_html
    %Q{
      <div style="color:#333; font-family: Helvetica; font-size: 150%;">
        Impulse v2.0
      </div>
    }
  end

  def initial_html
    %Q{
      <div style="color:#333; font-family: Helvetica;">
        <img src='#{uri_to_icon(:information)}'/>
      </div>
    }
  end

  # листья дерева
  def leaf(text, component, icon = nil)
    { text: text,
      icon: icon && uri_to_icon(icon),
      cmp: component,
      leaf: true
    }
  end

  def menu
    out = { :text => "Навигация",
      :expanded => true,
      :children => [

        { :text => "Базовые компоненты",
          :expanded => true,
          :children => [

            { :text => "Справочники",
              :expanded => true,
              :children => [
                leaf("Наборы", :cmps, :user_suit),
                leaf("Специальности", :cmp_speciality_grid, :user),
                leaf("Кафедры", :depts, :user),
                leaf("Районы", :district_grid, :user),
                leaf("Район-Місто", :village_grid, :user),
                leaf("Разделы", :diplom_topic_grid, :user_suit)
              ]
            },

            { text: "Люди",
              expanded: true,
              children: [
                leaf("Студенты", :undergraduate_grid, :application),
                leaf("Персоналии", :window_with_grid, :application_view_detail),
                leaf("Преподаватели", :window_nesting_bosses_and_clerks, :application_tile_horizontal),
                leaf("Рецензенты", :reviewer_grid, :application_tile_horizontal)
              ]
            }
          ]
        },

        { :text => "Составные компоненты",
          :expanded => true,
          :children => [
            leaf("Bosses and Clerks", :bosses_and_clerks, :user_user_suit),
            leaf("TabPanel (static)", :static_tab_panel, :bullet_black),
            leaf("TabPanel (dynamic)", :dynamic_tab_panel, :bullet_black),
            leaf("Accordion (static)", :static_accordion, :bullet_black),
            leaf("Accordion (dynamic)", :dynamic_accordion, :bullet_black),
            leaf("Клерк-инспектор", :clerk_inspector, :bullet_black)
          ]
        }
      ]
    }

    if current_user
      out[:children] << { text: "Private components", expanded: true, children: [ leaf("For authenticated users", :for_authenticated, :lock) ]}
    end

    out
  end
end
