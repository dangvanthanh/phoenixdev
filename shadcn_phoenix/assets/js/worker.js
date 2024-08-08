self.onmessage = (e) => {
    // Worker logic here
    const result = e.data * 2; // Example: double the input
    self.postMessage(result);
};