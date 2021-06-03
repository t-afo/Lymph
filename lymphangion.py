class lymph:
    # Class attributes

    def __init__(self, D, p1, p2,Q1, Q2):
        self.diameter = D
        self.pin = p1
        self.pout = p2
        self.pm = (p1 + p2) / 2
        self.flowin = Q1
        self.flowout = Q2
