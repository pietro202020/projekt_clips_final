import clips

class SystemEkspercki:
    def __init__(self, file):
        self.env = clips.Environment()
        self.env.load(file)
    def run(self):
        self.env.run()
    def fakty(self):
        return self.env.facts()
    def string_add(self, string):
        self.env.assert_string(string)
    def odpowiedz(self, answer):
        self.string_add(f'(odpowiedz "{answer}")')
    def retract_ost(self, question_fact_str):
        self.string_add(f'(pytanie {question_fact_str})')
        for fact in self.fakty():
            fact.retract()