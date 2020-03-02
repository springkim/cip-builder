#include <iostream>
#include <Eigen/Dense>
/*
[1 2]    [1 2 3]     [9  12 15]
[3 4]  x [4 5 6]  =  [19 26 33]
[5 6]                [29 40 51]
*/
int main() {
	Eigen::MatrixXd a(3, 2);
	a << 1, 2, 3, 4, 5, 6;
	Eigen::MatrixXd b(2, 3);
	b << 1, 2, 3, 4, 5, 6;
	std::cout << a * b << std::endl;
}