#!/bin/bash

# Backup the file first
cp src/pages/index.astro backup_with_animations.astro

# Use awk to make the proper replacements
awk '
BEGIN { 
    in_target_section = 0
    added_css = 0
}
{
    if (match($0, /Presenciou algum crime contra criança ou adolescente\? Chame o Conselho Tutelar do seu município\./)) {
        in_target_section = 1
        # Modify the h1 tag to include the animation class
        gsub(/class="text-3xl md:text-4xl lg:text-5xl font-bold text-white leading-tight"/, 
             "class=\"text-3xl md:text-4xl lg:text-5xl font-bold text-white leading-tight animate-dramatic-pulse\"")
        print $0
    } 
    else if (in_target_section && !added_css && /<\/section>/ && !/Nova seção com informações/) {
        added_css = 1
        print $0
        print "      <style>"
        print "        @keyframes dramatic-pulse {"
        print "          0% {"
        print "            opacity: 0.3;"
        print "            transform: scale(0.95);"
        print "            text-shadow: 0 0 5px rgba(217, 14, 70, 0.3);"
        print "          }"
        print "          50% {"
        print "            opacity: 1;"
        print "            transform: scale(1.02);"
        print "            text-shadow: 0 0 20px rgba(217, 14, 70, 0.7);"
        print "          }"
        print "          100% {"
        print "            opacity: 0.3;"
        print "            transform: scale(0.95);"
        print "            text-shadow: 0 0 5px rgba(217, 14, 70, 0.3);"
        print "          }"
        print "        }"
        print "        "
        print "        @keyframes dramatic-flicker {"
        print "          0%, 19%, 21%, 23%, 25%, 54%, 56%, 100% {"
        print "            opacity: 1;"
        print "            text-shadow: 0 0 10px rgba(255, 255, 255, 0.5);"
        print "          }"
        print "          20%, 24%, 55% {"
        print "            opacity: 0.6;"
        print "            text-shadow: none;"
        print "          }"
        print "        }"
        print "        "
        print "        .animate-dramatic-pulse {"
        print "          animation: dramatic-pulse 3s ease-in-out infinite, dramatic-flicker 2s infinite;"
        print "        }"
        print "      </style>"
    }
    else {
        print $0
    }
}
' backup_with_animations.astro > src/pages/index.astro
