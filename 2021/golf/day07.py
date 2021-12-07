def main():
    nums = sorted(map(int, input().split(',')))
    print(easy(nums))
    print(hard(nums))

def easy(nums):
    m = nums[len(nums)//2]
    return sum(abs(m-n) for n in nums)

def hard(nums):
    # leftCost[d] tells us how much it costs for crabs to the left of d to move to d
    # rightCost[d] tells us how much it costs for crabs to the right of d to move to d
    # leftCost[d] + rightCost[d] tells us how much it costs for all crabs to move to d
    leftCost = []
    rightCost = []
    
    crabs = 0
    moveCost = 0
    # fill leftCost
    for d in range(nums[0], nums[-1]+1):
        leftCost.append(leftCost[-1] + moveCost if leftCost else 0)
        while crabs < len(nums) and nums[crabs] == d:
            crabs += 1
        moveCost += crabs

    crabs = 0
    moveCost = 0
    # fill rightCost
    for d in range(nums[-1], nums[0]-1, -1):
        rightCost.append(rightCost[-1] + moveCost if rightCost else 0)
        while crabs < len(nums) and nums[-crabs-1] == d:
            crabs += 1
        moveCost += crabs
    
    return min(left + right for left, right in zip(leftCost, reversed(rightCost)))

if __name__ == '__main__':
    main()
    
