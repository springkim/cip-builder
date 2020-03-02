
#include <stdlib.h>
#include <math.h>
#include <hdf5.h>

int main(void) {
	H5T_NATIVE_LONG_g;
	hsize_t dims_of_int_array[] = { 3,4 };
	hsize_t dims_of_int_dataspace[] = { 2,2 };

	int *data = (int *)malloc(2 * 2 * 3 * 4 * sizeof(int));
	int i;
	for (i = 0; i < 48; i++) data[i] = i;

	hid_t file = H5Fcreate("multset.h5", H5F_ACC_TRUNC, H5P_DEFAULT, H5P_DEFAULT);
	hid_t mem_h5t = H5Tarray_create(H5T_NATIVE_INT, 2, dims_of_int_array);
	hid_t dataspace = H5Screate_simple(2, dims_of_int_dataspace, NULL);
	hid_t dataset = H5Dcreate(file, "int_data", mem_h5t, dataspace, H5P_DEFAULT, H5P_DEFAULT, H5P_DEFAULT);
	H5Dwrite(dataset, mem_h5t, H5S_ALL, H5S_ALL, H5P_DEFAULT, data);

	H5Dclose(dataset);
	H5Sclose(dataspace);
	H5Tclose(mem_h5t);
	free(data);

	// second verse, not quite the same as the first...

	long *ldata = (long*)malloc(20 * sizeof(long));
	for (i = 0; i < 20; i++) ldata[i] = i;

	hsize_t dims_of_long_array[] = { 5 };
	mem_h5t = H5Tarray_create(H5T_NATIVE_LONG, 1, dims_of_long_array);
	dataspace = H5Screate_simple(2, dims_of_int_dataspace, NULL); // use same dims as int ds
	dataset = H5Dcreate(file, "long_data", mem_h5t, dataspace, H5P_DEFAULT, H5P_DEFAULT, H5P_DEFAULT);
	H5Dwrite(dataset, mem_h5t, H5S_ALL, H5S_ALL, H5P_DEFAULT, ldata);

	H5Dclose(dataset);
	H5Sclose(dataspace);
	H5Tclose(mem_h5t);
	free(ldata);

	// third verse, complete cast of chars

	const char *cdata[] = { "Moe", "Larry", "Curly" };

	hsize_t dims_of_char_array[] = { 3 };
	hsize_t dims_of_char_dataspace[] = { 1 };
	hid_t vlstr_h5t = H5Tcopy(H5T_C_S1);
	H5Tset_size(vlstr_h5t, H5T_VARIABLE);
	mem_h5t = H5Tarray_create(vlstr_h5t, 1, dims_of_char_array);
	dataspace = H5Screate_simple(1, dims_of_char_dataspace, NULL); // use same dims as int ds
	dataset = H5Dcreate(file, "char_data", mem_h5t, dataspace, H5P_DEFAULT, H5P_DEFAULT, H5P_DEFAULT);
	H5Dwrite(dataset, mem_h5t, H5S_ALL, H5S_ALL, H5P_DEFAULT, cdata);

	H5Dclose(dataset);
	H5Sclose(dataspace);
	H5Tclose(mem_h5t);
	H5Tclose(vlstr_h5t);

	// now a challenge... try wrapping the char data with a struct...
	typedef struct {
		char* name ;
		int  id;
	} user_t;

	user_t user_data[1][2];

	user_data[0][0].name = (char*)"Alice";
	user_data[0][1].name = (char*)"Bob";
	user_data[0][0].id = 25;
	user_data[0][1].id = 52;

	hsize_t dims_of_user_array[] = { 1,2 };
	hsize_t dims_of_user_dataspace[] = { 1 };
	vlstr_h5t = H5Tcopy(H5T_C_S1);
	H5Tset_size(vlstr_h5t, H5T_VARIABLE);
	hid_t user_h5t = H5Tcreate(H5T_COMPOUND, sizeof(user_t)); // create compound type for user_t
	H5Tinsert(user_h5t, "User Name", HOFFSET(user_t, name), vlstr_h5t);
	H5Tinsert(user_h5t, "User ID", HOFFSET(user_t, id), H5T_NATIVE_INT);
	mem_h5t = H5Tarray_create(user_h5t, 2, dims_of_user_array);
	dataspace = H5Screate_simple(1, dims_of_user_dataspace, NULL);
	dataset = H5Dcreate(file, "user_data", mem_h5t, dataspace, H5P_DEFAULT, H5P_DEFAULT, H5P_DEFAULT);
	H5Dwrite(dataset, mem_h5t, H5S_ALL, H5S_ALL, H5P_DEFAULT, user_data);

	H5Dclose(dataset);
	H5Sclose(dataspace);
	H5Tclose(mem_h5t);
	H5Tclose(user_h5t);
	H5Tclose(vlstr_h5t);


	// try a block of pointers to malloc'd strings...

	char *string_data[5];
	for (i = 0; i < 5; i++) {
		int j;
		string_data[i] = (char*)malloc(6 * sizeof(char));
		for (j = 0; j < i; j++) string_data[i][j] = (char)(64 + pow(2, i - 1) + j);
		string_data[i][j] = 0; // null terminator
	}

	hsize_t dims_of_string_array[] = { 5 };
	hsize_t dims_of_string_dataspace[] = { 1 };
	vlstr_h5t = H5Tcopy(H5T_C_S1);
	H5Tset_size(vlstr_h5t, H5T_VARIABLE);
	mem_h5t = H5Tarray_create(vlstr_h5t, 1, dims_of_string_array);
	dataspace = H5Screate_simple(1, dims_of_string_dataspace, NULL);
	dataset = H5Dcreate(file, "string_data", mem_h5t, dataspace, H5P_DEFAULT, H5P_DEFAULT, H5P_DEFAULT);
	H5Dwrite(dataset, mem_h5t, H5S_ALL, H5S_ALL, H5P_DEFAULT, string_data);

	H5Dclose(dataset);
	H5Sclose(dataspace);
	H5Tclose(mem_h5t);
	H5Tclose(vlstr_h5t);

	for (i = 0; i < 5; i++) free(string_data[i]); // every malloc deserves a free... 

	H5Fclose(file);

	return 0;
}