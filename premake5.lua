workspace "EasyVulkan"
    architecture "x64"
    startproject "EasyVulkan"
    
    configurations
    {
        "Debug",
        "Release",
        "Dist"
    }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to root folder {solution directory}
IncludeDir = {}
IncludeDir["Vulkan"] = "EasyVulkan/vendor/Vulkan/Include"
IncludeDir["GLFW"] = "EasyVulkan/vendor/GLFW/include"
IncludeDir["glm"] = "EasyVulkan/vendor/glm"
IncludeDir["stb_image"] = "EasyVulkan/vendor/stb_image"

include "EasyVulkan/vendor/GLFW"

project "EasyVulkan"
    location "EasyVulkan"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++20"
    staticruntime "off"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp",
        "%{prj.name}/vendor/stb_image/**.h",
        "%{prj.name}/vendor/stb_image/**.cpp",
        "%{prj.name}/vendor/glm/glm/**.hpp",
        "%{prj.name}/vendor/glm/glm/**.inl"
    }

    includedirs
    {
        "Hazel/src",
        "%{IncludeDir.Vulkan}",
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.glm}",
        "%{IncludeDir.stb_image}"
    }

    libdirs
    {
        "EasyVulkan/vendor/Vulkan/Lib"
    }

    links
    {
        "vulkan-1",
        "GLFW"
    }

    -- pchsource "Hazel/src/hzpch.cpp"
    -- pchheader "hzpch.h"

    filter "system:windows"
        systemversion "latest"

        defines
        {
            "HZ_PLATFORM_WINDOWS",
            "HZ_ENABLE_ASSERTS",
            "GLFW_INCLUDE_NONE"
        }

    filter "configurations:Debug"
        defines { "VK_DEBUG" }
        runtime "Debug"
        symbols "On"

    filter "configurations:Release"
        defines { "VK_NDEBUG" }
        runtime "Release"
        optimize "On"
    
    filter "configurations:Dist"
        defines { "VK_DIST" }
        runtime "Release"
        optimize "On"