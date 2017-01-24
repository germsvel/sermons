defmodule Sermons.SlugTest do
  use ExUnit.Case, async: true
  alias Sermons.Slug

  describe ".generate/1" do
    test "returns nil when passed nil" do
      slug = Slug.generate(nil)

      assert slug == nil
    end

    test "downcases a string" do
      slug = Slug.generate("Hello")

      assert slug == "hello"
    end

    test "replaces whitespaces with dashes" do
      slug = Slug.generate("Hello World")

      assert slug == "hello-world"
    end

    test "removes parenthesis" do
      slug = Slug.generate("Hello World (part 1)")

      assert slug == "hello-world-part-1"
    end

    test "removes other characters" do
      slug = Slug.generate("Hello, World. I say: let's do this [part 1]")

      assert slug == "hello-world-i-say-lets-do-this-part-1"
    end
  end
end
