#include <iostream>
#include <bits/stdc++.h>
using namespace std;

int main() {

    int T = 0;
    cin >> T;
    while (T--) {
        int n;
        cin >> n;
        // string s;
        // cin >> s;
        vector<int>arr(n,0);
        for (int i = 0; i < n; i++) cin >> arr[i];
        helper(arr, n);
    }
}