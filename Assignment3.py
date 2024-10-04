def sort_even_odd(input):

    even_numbers = [num for num in input if num % 2 == 0]
    odd_numbers = [num for num in input if num % 2 != 0]

    even_numbers.sort(reverse=True)
    odd_numbers.sort(reverse=True)

    return even_numbers + odd_numbers

input = [3, 2, 5, 1, 8, 9, 6]
output = sort_even_odd(input)
print(f"Input: {input}")
print(f"Output: {output}")