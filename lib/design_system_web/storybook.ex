defmodule DesignSystemWeb.Storybook do
  use PhoenixStorybook,
    otp_app: :design_system,
    content_path: Path.expand("../../storybook", __DIR__),
    # assets path are remote path, not local file-system paths
    css_path: "/assets/app.css",
    js_path: "/assets/storybook.js",
    sandbox_class: "pescarte"
end
