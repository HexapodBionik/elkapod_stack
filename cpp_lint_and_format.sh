echo -e "\e[32mLinting all \e[1;37m.cpp\e[0m\e[32m and \e[1;37m.h/.hpp\e[0m\e[32m files inside \e[1;37msrc/\e[0m\e[32m directory\e[0m\n"
cppcheck --std=c++20 src/
echo
echo -e "\e[32mFormatting all \e[1;37m.cpp\e[0m\e[32m and \e[1;37m.h/.hpp\e[0m\e[32m files inside \e[1;37msrc/\e[0m\e[32m directory\e[0m\n"
fdfind --no-ignore -e cpp -e hpp -e h . src/ -x clang-format -i
