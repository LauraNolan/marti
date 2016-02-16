from crits.vocabulary.vocab import vocab
import stix.common.kill_chains.lmco as lmco

class KillChain(vocab):
    """
    Vocabulary for Kill Chain.
    """

    RECON = str(lmco.PHASE_RECONNAISSANCE.ordinality) + ". " + lmco.PHASE_RECONNAISSANCE.name
    WEAPONIZE = str(lmco.PHASE_WEAPONIZE.ordinality) + ". " + lmco.PHASE_WEAPONIZE.name
    DELIVER = str(lmco.PHASE_DELIVERY.ordinality) + ". " + lmco.PHASE_DELIVERY.name
    EXPLOIT = str(lmco.PHASE_EXPLOITATION.ordinality) + ". " + lmco.PHASE_EXPLOITATION.name
    INSTALL = str(lmco.PHASE_INSTALLATION.ordinality) + ". " + lmco.PHASE_INSTALLATION.name
    CONTROL = str(lmco.PHASE_COMMAND_AND_CONTROL.ordinality) + ". " + lmco.PHASE_COMMAND_AND_CONTROL.name
    ACTIONS = str(lmco.PHASE_ACTIONS_AND_OBJECTIVES.ordinality) + ". " + lmco.PHASE_ACTIONS_AND_OBJECTIVES.name