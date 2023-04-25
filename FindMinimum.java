package recursion;

public class FindMin {

	public static int recursive(int[] array, int start) {
		if(start + 1 == array.length) return array[start];
		int left  = array[start], right = recursive(array, start+1);
		return (left > right) ? right : left;
	}

	public static void main(String[] args) {
		int [] array = {5, 20, 10, 34, 100, 2400, 2, -7, 3, -5, -4};
		System.out.println(recursive(array, 0));
	}

}
