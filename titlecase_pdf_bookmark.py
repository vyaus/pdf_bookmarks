#!/usr/bin/env python3
import re
import sys

def to_title_case(text):
    """
    将文本转换为标题格式（每个单词首字母大写，特定介词小写）
    """
    # 定义需要小写的介词和连词
    upper_words = {'RPM', 'CNC', 'ANSI', 'SI', 'ISO', 'U.S.', 'GD&T', 'AWS'}
    lower_words = {'a', 'an', 'and', 'the', 'or', 'but', 'for', 'nor', 
                  'on', 'at', 'to', 'from', 'by', 'of', 'in', 'with', 'as'}
    
    words = text.split()
    if not words:
        return text
    
    # 处理每个单词
    result = []
    for i, word in enumerate(words):
        if word.upper() in upper_words:
            result.append(word.upper())
            print(text)
            continue
        # 如果是第一个词或者不在小写列表中的词，首字母大写
        if i == 0 or word.lower() not in lower_words:
            # 处理可能带有连字符的单词
            if '-' in word:
                parts = word.split('-')
                processed = '-'.join([p.capitalize() for p in parts])
                result.append(processed)
            else:
                result.append(word.capitalize())
        else:
            result.append(word.lower())
    
    return ' '.join(result)

def process_file(filename):
    """
    处理文件，将 BookmarkTitle 后的大写文本转换为标题格式
    """
    # 匹配 BookmarkTitle 后的大写文本
    pattern = r'(BookmarkTitle:\s+)([A-Z][A-Z0-9,\.\-\&_ \t]*)\n'
    # pattern = r'(BookmarkTitle:\s+)([^a-z]*)$'
    
    with open(filename, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 替换函数
    def replace_match(match):
        prefix = match.group(1)  # BookmarkTitle 和后面的空格
        upper_text = match.group(2)  # 全大写的文本
        title_text = to_title_case(upper_text.lower())
        return prefix + title_text + '\n'
    
    # 执行替换
    new_content = re.sub(pattern, replace_match, content)
    
    # 写回文件
    with open(filename, 'w', encoding='utf-8') as f:
        f.write(new_content)
    
    print(f"已处理文件: {filename}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("使用方法: python titlecase_pdf_bookmark.py <文件名>")
        sys.exit(1)
    
    process_file(sys.argv[1])
